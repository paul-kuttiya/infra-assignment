import json
import time

def lambda_handler(event, context):
    current_epoch_time = int(time.time())
    response_body = {"The current epoch time": current_epoch_time}

    resp = {
        'statusCode': 200,
        'body': json.dumps(response_body)
    }

    print(resp)
    return resp
