#!/usr/bin/python3

import boto3
import shutil
import sys

text = sys.argv[1]
out = sys.argv[2]

client = boto3.client("polly")

resp = client.synthesize_speech(
    Engine="standard",
    LanguageCode="en-US",
    OutputFormat="ogg_vorbis",
    SampleRate="22050",
    Text=text,
    VoiceId="Joanna",
)

with open(out, "wb") as f:
    shutil.copyfileobj(resp["AudioStream"], f)
