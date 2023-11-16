#Create a Python script that will send a Slack message to your group chat when the Jenkins pipeline is done.

import requests
import os
import json

def slack_notif(message):
    url = os.getenv("webhook_url")
    content={
        "text": message
    }

    post = requests.post(url, json=content)

    if post.status_code != 200:
        print(f"Failed to send Slack message. Status code: {post.status_code}")
    else:
        print("Slack message sent successfully!")


pipeline_status = os.getenv("pipeline_status")

if pipeline_status == "SUCCESS":
    message = "The Jenkins pipeline completed successfully! :)"
    slack_notif(message)
else:
    message = "The Jenkins pipeline failed :("
    slack_notif(message)
