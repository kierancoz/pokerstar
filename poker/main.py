from image_converter import ImageConverter
import subprocess
import argparse
import os


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--compiled", dest="compiled", default=True, help="compiled")
    parser.add_argument("--install-dir", dest="install_dir", default="../", help="Install directory")
    return parser.parse_args()

def main():
    args = get_args()
    image_dir = os.path.abspath(os.path.join(args.install_dir, "images"))
    image_converter = ImageConverter(image_dir)
    
    if args.compiled:
        subprocess.call(["../../autohotkey/autohotkey.exe", "getGameInfo.ahk", image_dir])
    else:
        subprocess.call(['getGameInfo.exe', image_dir])
    tesseract_dir = os.path.join(args.install_dir, "tp/Tesseract-OCR/tesseract.exe")
    payout = image_converter.get_payout(tesseract_dir)


if __name__ == "__main__":
    main()