! Tests that excessive tabs (\t) and newlines (\n) are correctly handed

! All whitepace comprises one tab
Window	WINDOW
	GROUP
		GROUP
		END
	END
END

! All whitepace comprises two tabs
Window		WINDOW
		GROUP
				GROUP
				END
		END
END



























! Window defined after lots of new lines
! All whitepace comprises two tabs
Window			WINDOW
			GROUP
					GROUP
					END
			END
END