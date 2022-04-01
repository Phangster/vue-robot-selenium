import random
import string
import base64
import numpy as np
import cv2
from pyzbar.pyzbar import decode

__version__ = '1.0.0'


class CustomLib(object):
    ROBOT_LIBRARY_VERSION = __version__
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def get_random_name(self, email_length):
        letters = string.ascii_lowercase[:12]
        return ''.join(random.choice(letters) for i in range(email_length))

    def generate_random_emails(self, length):

        domains = ["hotmail.com", "gmail.com", "aol.com",
                   "mail.com", "mail.kz", "yahoo.com"]

        return [self.get_random_name(length)
                + '@'
                + random.choice(domains)]


    # def decode(self, base64Image):
    #     img=cv2.imread('tests/e2e/lib/test_qr.png')
    #     result = decode(img)
    #     return result

    def decode(self, base64Image):
        im = np.fromstring(base64.b64decode(base64Image.split(',')[1]), np.uint8)
        img = cv2.imdecode(im, 1)
        result = decode(img)
        for i in result:
            return i.data.decode("utf-8")