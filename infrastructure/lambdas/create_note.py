import datetime
import json
import os
import uuid
import boto3

def lambda_handler(event, context): 
    """Body expected:
    {
        "id": "ID",

    }
    """
    print(event)
    if not event["body"] or event["body"] == "": 
        return {"statusCode": 400, "headers": {}, "body": "Bad request"}
    action: dict[str, str] = json.loads(event["body"]) 
    params = { 
        # "GameTitle": action['game_name'],
        "noteId": action['id'],
        "name": action['name']

    }
    try:
        db_response = dynamo_table().put_item(Item=params) 
        print(db_response)
        return {"statusCode": 201, "headers": {}, "body":json.dumps(params)}
    except Exception as e:
        print(e)
        return {"statusCode": 500, "headers": {}, "body": "Internal Server Error"}
    

    
def dynamo_table():
    table_name = os.environ.get("NOTES_TABLE", "Actions")
    region = os.environ.get("REGION", "eu-central-1")
    # aws_environment = os.environ.get("AWSENV", "AWS")

    actions_table = boto3.resource(
             "dynamodb", region_name=region
        )
    return actions_table.Table(table_name)


