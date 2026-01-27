import json
import logging
import uuid
import re


def create_uuid():
    return str(hex(uuid.uuid4().fields[0]))[2:]


def build_plan(plan_dag, stream, id=None):

    # create a plan id
    if id is None:
        id = create_uuid()

    # plan context, initial streams, scope
    plan_context = {"scope": stream[:-7], "streams": {plan_dag[0][0]: stream}}

    # construct plan
    plan = {"id": id, "steps": plan_dag, "context": plan_context}

    return plan


def write_to_new_stream(worker, content, output, id=None, tags=None):

    # create a unique id
    if id is None:
        id = create_uuid()

    if worker:
        output_stream = worker.write_data(content, output=output, id=id, tags=tags)
        worker.write_eos(output=output, id=id)

    return output_stream
