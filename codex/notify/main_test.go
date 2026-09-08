package main

import (
	"strings"
	"testing"
	"unicode/utf8"
)

func TestFormat(t *testing.T) {
	title, body := format(event{
		WorkingDirectory:     "/home/example/project",
		LastAssistantMessage: "Implemented the change.\n\nTests pass.",
	})

	if title != "Codex finished · project" {
		t.Fatalf("unexpected title: %q", title)
	}
	if body != "Implemented the change. Tests pass." {
		t.Fatalf("unexpected body: %q", body)
	}
}

func TestFormatFallsBackToCompletionMessage(t *testing.T) {
	_, body := format(event{})
	if body != "Task completed." {
		t.Fatalf("unexpected fallback body: %q", body)
	}
}

func TestTruncatePreservesUTF8(t *testing.T) {
	value := strings.Repeat("я", maxBodyCharacters+10)
	result := truncate(value, maxBodyCharacters)

	if !utf8.ValidString(result) {
		t.Fatal("truncated body is not valid UTF-8")
	}
	if utf8.RuneCountInString(result) != maxBodyCharacters {
		t.Fatalf("unexpected character count: %d", utf8.RuneCountInString(result))
	}
	if !strings.HasSuffix(result, "…") {
		t.Fatal("truncated body has no ellipsis")
	}
}
