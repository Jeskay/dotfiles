package main

import (
	"encoding/json"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"syscall"
	"time"
	"unicode/utf8"
)

const (
	completionEvent   = "agent-turn-complete"
	deliveryDelay     = time.Second
	notificationTTL   = "5000"
	maxBodyCharacters = 500
)

type event struct {
	Type                 string `json:"type"`
	WorkingDirectory     string `json:"cwd"`
	LastAssistantMessage string `json:"last-assistant-message"`
}

func main() {
	if len(os.Args) == 4 && os.Args[1] == "--deliver" {
		deliver(os.Args[2], os.Args[3])
		return
	}

	if len(os.Args) != 2 {
		return
	}

	var notification event
	if err := json.Unmarshal([]byte(os.Args[1]), &notification); err != nil {
		return
	}
	if notification.Type != completionEvent {
		return
	}

	title, body := format(notification)
	detachDelivery(title, body)
}

func format(notification event) (string, string) {
	title := "Codex finished"
	if project := filepath.Base(filepath.Clean(notification.WorkingDirectory)); project != "." {
		title += " · " + project
	}

	body := strings.Join(strings.Fields(notification.LastAssistantMessage), " ")
	if body == "" {
		body = "Task completed."
	}
	return title, truncate(body, maxBodyCharacters)
}

func truncate(value string, limit int) string {
	if utf8.RuneCountInString(value) <= limit {
		return value
	}

	runes := []rune(value)
	return strings.TrimSpace(string(runes[:limit-1])) + "…"
}

func detachDelivery(title, body string) {
	executable, err := os.Executable()
	if err != nil {
		return
	}

	command := exec.Command(executable, "--deliver", title, body)
	command.SysProcAttr = &syscall.SysProcAttr{Setsid: true}
	_ = command.Start()
}

func deliver(title, body string) {
	time.Sleep(deliveryDelay)
	command := exec.Command(
		"notify-send",
		"--app-name=Codex",
		"--expire-time="+notificationTTL,
		"--",
		title,
		body,
	)
	_ = command.Run()
}
