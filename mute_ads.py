

import pyautogui
import pytesseract
import numpy as np
import cv2
import subprocess
import re
import time
from PIL import Image
import imagehash
import pyscreenshot as ImageGrab

# Define the command you want to execute
brave_id = None
def mute():
    try: 
        cmd = ["pacmd", "list-sink-inputs"]

        # Use subprocess.run() to execute the command
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

        results = result.stdout.split('index: ')
        results.pop(0)
        app = {
            'index': 0,
            'name': '',
            'state': '',
        }
        app_list = []
        for result in results:
            app['index'] = result.split(' ')[0]
            app['index'] = re.findall(r'\d+', app['index'])[0]
            app['name'] = result.split('application.name = "')[1].split('"')[0]
            app['state'] = result.split('state: ')[1].split(' ')[0]
            app['state'] = re.findall(r'[A-Z]+', app['state'])[0]
            # print(app)
            app_list.append(app)
            app = {}

        # is_only_spotify_running = True
        brave_id = 0
        # print(app_list)
        for app in app_list:
            # print(app)
            if 'brave' in app['name'].lower():
                if 'running' in app['state'].lower():
                    # print("brave is running")
                    brave_id = app['index']
                    # print(brave_id)
                    subprocess.run(['pactl', 'set-sink-input-volume', brave_id, '0%'])  
                else:
                    subprocess.run(['pactl', 'set-sink-input-volume', brave_id, '140%'])

    except Exception as e:
        # print(e)
        pass

def unmute():
    try: 
        cmd = ["pacmd", "list-sink-inputs"]

        # Use subprocess.run() to execute the command
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

        results = result.stdout.split('index: ')
        results.pop(0)
        app = {
            'index': 0,
            'name': '',
            'state': '',
        }
        app_list = []
        for result in results:
            app['index'] = result.split(' ')[0]
            app['index'] = re.findall(r'\d+', app['index'])[0]
            app['name'] = result.split('application.name = "')[1].split('"')[0]
            app['state'] = result.split('state: ')[1].split(' ')[0]
            app['state'] = re.findall(r'[A-Z]+', app['state'])[0]
            # print(app)
            app_list.append(app)
            app = {}

        # is_only_spotify_running = True
        brave_id = 0
        # print(app_list)
        for app in app_list:
            # print(app)
            if 'brave' in app['name'].lower():
                brave_id = app['index']
                # print(brave_id)
                subprocess.run(['pactl', 'set-sink-input-volume', brave_id, '140%'])  

    except Exception as e:
        # print(e)
        pass

# Define the region of interest (ROI) for the bottom left portion of the screen
left = 0
top = pyautogui.size().height - 200  # Adjust the height as needed
width = 600  # Adjust the width as needed
height = 200  # Adjust the height as needed

def check_if_on():
    # Capture the screenshot of the ROI
    screenshot = pyautogui.screenshot(region=(left, top, width, height))

    # Open the image using PIL (Python Imaging Library)
    screenshot_cv = cv2.cvtColor(np.array(screenshot), cv2.COLOR_RGB2BGR)

    # Convert PIL image to OpenCV format (BGR)
    image_cv = cv2.cvtColor(np.array(screenshot_cv), cv2.COLOR_RGB2BGR)

    # Apply preprocessing steps
    # Example: Enhance contrast and apply thresholding
    enhanced_image = cv2.convertScaleAbs(image_cv, alpha=1, beta=0)
    gray_image = cv2.cvtColor(enhanced_image, cv2.COLOR_BGR2GRAY)
    thresholded_image = cv2.threshold(gray_image, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)[1]


    # save this file
    cv2.imwrite('thresholded_image.png', thresholded_image)

    # custom_config = r'--oem 3 --psm 7 -l eng+deu --dpi 300'

    # Use Tesseract to perform text recognition
    text = pytesseract.image_to_string(screenshot)
    print(text)
    # Define the keyword to search for
    keywords = ['INDIA', '>', '»']

    on = False
    for i in keywords:
        if i in text:
            on = True
            break

    print(on)
    return on

def check_if_on_ss():
    # Define the region to capture (left, top, right, bottom)
    region = (160, 80, 195, 120)  # Example: Capture a 300x300 pixel region from the top-left

    # Capture the screenshot
    screenshot = ImageGrab.grab(bbox=region)

    # # Save the screenshot for visual comparison
    # screenshot.save('captured_screenshot.png')

    # Load the reference image
    reference_image = Image.open('ref.png')

    # Calculate the hash for the reference image
    reference_hash = imagehash.average_hash(reference_image)

    # Calculate the hash for the screenshot
    screenshot_hash = imagehash.average_hash(screenshot)

    # Define a threshold for similarity (adjust as needed)
    threshold = 20

    # Calculate the Hamming distance between the hashes
    hamming_distance = screenshot_hash - reference_hash

    # print(hamming_distance, reference_hash, screenshot_hash)

    return hamming_distance < threshold

if __name__ == "__main__":
    while(True):
        text = check_if_on()
        the_image = check_if_on_ss()
        print("text", text)
        print("the_image", the_image)
        if text == True or the_image == True:
            unmute()
        if text == False and the_image == False:
            print("mute")
            mute()
        time.sleep(0.2)
