import requests
import os


def get_lines(day, year="2024", force_download=False, split_lines=True):
    file_name = f"day{str(day).zfill(2)}.input"
    if os.path.exists(file_name) and not force_download:
        text = open(file_name, 'r').read()
        return text.splitlines() if split_lines else text
    elif os.path.exists("session.cookie"):
        print("Input download forced..." if force_download else "Input file missing. Downloading input...")
        session = {"session": open(f"session.cookie", 'r').read()}
        response = requests.get(f"https://adventofcode.com/{year}/day/{day}/input", cookies=session)
        response.raise_for_status()
        open(file_name, 'wb').write(response.content)
        print(f"Input successfully saved to {file_name}")
        return get_lines(day, year=year, split_lines=split_lines)
    else:
        raise FileNotFoundError("Session file (session.cookie) missing. Could not download input.")
