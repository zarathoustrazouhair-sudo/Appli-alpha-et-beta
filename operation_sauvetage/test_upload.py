import unittest
from unittest.mock import patch, MagicMock
import subprocess
from operation_sauvetage.upload import run_command

class TestUpload(unittest.TestCase):

    @patch('subprocess.run')
    def test_run_command_success(self, mock_run):
        # Configure the mock to return a successful result
        mock_run.return_value = MagicMock(returncode=0, stdout="success", stderr="")

        command = ["ls"]
        result = run_command(command)

        self.assertEqual(result, 0)
        mock_run.assert_called_once_with(command, capture_output=True, text=True)

    @patch('subprocess.run')
    def test_run_command_failure(self, mock_run):
        # Configure the mock to return a failure result (e.g., returncode 1)
        mock_run.return_value = MagicMock(returncode=1, stdout="", stderr="error")

        command = ["ls", "non_existent"]
        result = run_command(command)

        self.assertEqual(result, 1)
        mock_run.assert_called_once_with(command, capture_output=True, text=True)

    @patch('subprocess.run')
    def test_run_command_with_stderr(self, mock_run):
        # Configure the mock to return a result with stderr
        mock_run.return_value = MagicMock(returncode=0, stdout="output", stderr="some warning")

        command = ["command_with_warning"]
        result = run_command(command)

        self.assertEqual(result, 0)
        mock_run.assert_called_once_with(command, capture_output=True, text=True)

    @patch('subprocess.run')
    def test_run_command_exception(self, mock_run):
        # Configure the mock to raise an exception
        mock_run.side_effect = Exception("Subprocess error")

        command = ["invalid_command"]
        result = run_command(command)

        self.assertEqual(result, -1)
        mock_run.assert_called_once_with(command, capture_output=True, text=True)

if __name__ == '__main__':
    unittest.main()
