# -*- coding: utf-8 -*-
#

import socket
import threading
import urllib
import urllib2
import logging
import hashlib
import json

logging.basicConfig()
logger = logging.getLogger(__name__)  # Write errors to PYthon logging output

# Seconds of web service timeout
WEBHOOK_HTTP_TIMEOUT = 30

OPEN_WEBHOOK_SECRET = "xxx"


class UrlThread(threading.Thread):
    """ A separate thread doing HTTP POST.

    So we won't block when calling the webhook.
    We also gracefully return and log if the
    Hubot could not be reached.
    """
    def __init__(self, url, data):
        threading.Thread.__init__(self)
        self.url = url
        self.data = data

    def run(self):
        orignal_timeout = socket.getdefaulttimeout()
        try:
            logger.debug("Connectiong to %s payload %s",
                         self.url,
                         json.dumps(self.data))
            self.data = urllib.urlencode(self.data)
            socket.setdefaulttimeout(WEBHOOK_HTTP_TIMEOUT)
            r = urllib2.urlopen(self.url, self.data)
            r.read()
        except Exception as e:
            logger.exception(e)
        finally:
            socket.setdefaulttimeout(orignal_timeout)

# Add some extra UTF-8 characters to make sure the encoding works
message = u"Hello Hubot! åäöåä"
chat_room = u"My chat room"

msg_encoded = message.encode("utf-8")
chat_encoded = chat_room.encode("utf-8")

signed = hashlib.md5(chat_encoded +
                     msg_encoded +
                     OPEN_WEBHOOK_SECRET).hexdigest()

t = UrlThread("http://127.0.0.1:8080/hubot/openwebhook/signed/md5/",
              {'msg': msg_encoded, 'chat': chat_encoded})
t.run()
