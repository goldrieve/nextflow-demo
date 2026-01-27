import sys
import subprocess
from datetime import datetime 

def write_git_info(base_dir, output):
    # Get repository URL
    repo_url = subprocess.check_output(
        ['git', 'remote', 'get-url', 'origin'],
        cwd=base_dir,
        text=True
    ).strip()

    # Get current commit hash
    commit_hash = subprocess.check_output(
        ['git', 'rev-parse', 'HEAD'],
        cwd=base_dir,
        text=True
    ).strip()

    # Get git status
    status = subprocess.check_output(
        ['git', 'status'],
        cwd=base_dir,
        text=True
    )

    # Get uncommitted changes (git diff)
    diff = subprocess.check_output(
        ['git', 'diff'],
        cwd=base_dir,
        text=True
    )

    date_time = str(datetime.now().strftime("%H%M%S_%d%m%Y"))

    with open(output, 'w') as f:
        f.write(f"Date and time stamp: " + date_time)
        f.write(f"Repository URL: {repo_url}\n")
        f.write(f"Commit Hash: {commit_hash}\n")
        f.write("Git status:\n")
        f.write(status)
        f.write("\nUncommitted changes:\n")
        f.write(diff)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(f"Usage: python {sys.argv[0]} <base_dir> <output_file>")
        sys.exit(1)
    base_dir = sys.argv[1]
    output = sys.argv[2]
    write_git_info(base_dir, output)