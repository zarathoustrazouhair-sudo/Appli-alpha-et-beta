import unittest
from unittest.mock import patch, MagicMock
import subprocess
from rescue_push import run_command

class TestRescuePush(unittest.TestCase):

    @patch('subprocess.run')
    def test_run_command_success(self, mock_run):
        # Configure mock to return success
        mock_run.return_value = MagicMock(returncode=0, stdout="Success output", stderr="")

        result = run_command(["echo", "hello"])

        self.assertTrue(result)
        mock_run.assert_called_once_with(
            ["echo", "hello"],
            capture_output=True,
            text=True,
            encoding='utf-8',
            errors='ignore'
        )

    @patch('subprocess.run')
    def test_run_command_failure(self, mock_run):
        # Configure mock to return failure
        mock_run.return_value = MagicMock(returncode=1, stdout="", stderr="Error message")

        result = run_command(["false"])

        self.assertFalse(result)
        mock_run.assert_called_once()

    @patch('subprocess.run')
    def test_run_command_exception(self, mock_run):
        # Configure mock to raise an exception
        mock_run.side_effect = Exception("Subprocess error")

        result = run_command(["nonexistent"])

        self.assertFalse(result)
        mock_run.assert_called_once()

if __name__ == '__main__':
    unittest.main()
