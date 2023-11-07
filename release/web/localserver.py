import subprocess
import webbrowser

# Replace these variables with your actual repository path
repo_path = "path/to/your/repository"
commit_message = "Automated commit"

# Commit your changes
try:
    subprocess.run(["git", "add", "."], cwd=repo_path)
    subprocess.run(["git", "commit", "-m", commit_message], cwd=repo_path)
    print("Changes committed successfully.")
except Exception as e:
    print(f"Error committing changes: {e}")

# Start a local web server
try:
    subprocess.run(["python", "-m", "http.server"], cwd=repo_path)
except Exception as e:
    print(f"Error starting the local web server: {e}")

# Open a browser with the website
webbrowser.open("http://localhost:8000")
