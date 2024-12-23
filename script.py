import requests
import sys
import re

def send_to_chatGPT(text):
    querystring=text
    url = "https://free-unoficial-gpt4o-mini-api-g70n.onrender.com/chat"
    # querystring = {"query":f"Привет"}
    response = requests.request("GET", url, data="", headers={"accept": "application/json"}, params=querystring)
    print(response.json()["results"])



# Start of script
if len(sys.argv)<=2:
    print("No error")
    quit()
else:
    if sys.argv[1] =="ask":
        querystring = {"query":f"{sys.argv[2]}"}
        send_to_chatGPT(querystring)
    else:
        error_command=sys.argv[1]
        error_text=sys.argv[2]
        # Changing string
        error_text = error_text.replace("'","").replace("\\","").replace("\"","").replace("\n","")
        print("\n")
        querystring = {"query":f"Очень кратко расскажи как решить проблему , без подробного описания, с командой {error_command} и вконце дай решение, без объяснения. Текст ошибки{error_text}"}
        send_to_chatGPT(querystring)
