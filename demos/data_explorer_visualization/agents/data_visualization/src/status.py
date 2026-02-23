from blue.stream import ControlCode
from blue.utils import uuid_utils


class StatusMessage:
    def __init__(self, agent_name, worker):
        self.agent = agent_name
        self.worker = worker
        self.c_id = uuid_utils.create_uuid()
        self.messages = []
        self.chat_template = "🤖 **{agent}** {status_msg}"
        self.progress_template = "🤖[{agent}] {status_msg}"
        self.append_status("starting...")

    def build_status_form(self):
        data_schema = {"type": "object", "properties": {}}
        ui_schema = {
            "type": "Markdown",
            "scope": "#/properties/status",
            "props": {"style": {}},
        }
        data = {"status": "\n".join(self.messages)}
        return {"schema": data_schema, "uischema": ui_schema, "data": data}

    def append_status(self, status_msg, value=0.0):
        self.messages.append(
            self.chat_template.format(agent=self.agent, status_msg=status_msg)
        )
        self.worker.write_control(
            ControlCode.CREATE_FORM,
            self.build_status_form(),
            output="STATUS",
            id=self.c_id,
        )
        self.worker.write_progress(
            label=self.progress_template.format(
                agent=self.agent, status_msg=status_msg
            ),
            value=value,
        )

    def update_status(self, status_msg, value=0.5):
        if len(self.messages) > 0:
            self.messages[-1] = self.chat_template.format(
                agent=self.agent, status_msg=status_msg
            )
        else:
            self.messages = [
                self.chat_template.format(agent=self.agent, status_msg=status_msg)
            ]
        self.worker.write_control(
            ControlCode.CREATE_FORM,
            self.build_status_form(),
            output="STATUS",
            id=self.c_id,
        )
        self.worker.write_progress(
            label=self.progress_template.format(
                agent=self.agent, status_msg=status_msg
            ),
            value=value,
        )
