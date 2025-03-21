# blue-examples

In this repo you can find many example demonstrations of blue agents and template agent code.

To try demos:
* Go to [demos](demos) page and explore base and experimental agents

Or you can check out:
* [template](agents/template): a template starter agent
* [interactive template](agents/template_interactive): a template starter agent with interactive forms

## openai service

Many of the examples in this repo use `OPENAI` service as the backend service of the agent. As such before trying these demos you need to create and start the `OPENAI` service. Please refer to the [Installation Documentation - Start Service](https://github.com/rit-git/blue/blob/v0.9/LOCAL-INSTALLATION.md#start-services) to do so, if you havent' already done so.

## example data

As part of installation, there is example data you can explore blue with, as shown below:

![example_data_registry](./docs/images/example_data_registry.png)

To allow blue agents discover the example data you will need to sync to extract schema and other metadata into the data registry.
You can do so using the blue web application. Once logged in, first click in `Data` under registries, and then click on `postgres_example` dataset in the registry. 
Then, select `Actions` and `Sync`.

If you reload the page now you should see `postgres` database listed under `Databases`. If you click click on `postgres` and then `public` you can explore the database schema.

![example_data_registry](./docs/images/databases.png)
![example_data_registry](./docs/images/collections.png)
![example_data_registry](./docs/images/schema.png)

You are now ready to play with this dataset in the examples!

</br>
</br>

# Disclosures:

This software may include, incorporate, or access open source software (OSS) components, datasets and other third party components, including those identified below. The license terms respectively governing the datasets and third-party components continue to govern those portions, and you agree to those license terms may limit any distribution, use, and copying. 

You may use any OSS components under the terms of their respective licenses, which may include BSD 3, Apache 2.0, and other licenses. In the event of conflicts between Megagon Labs, Inc. (“Megagon”) license conditions and the OSS license conditions, the applicable OSS conditions governing the corresponding OSS components shall prevail. 

You agree not to, and are not permitted to, distribute actual datasets used with the OSS components listed below. You agree and are limited to distribute only links to datasets from known sources by listing them in the datasets overview table below. You agree that any right to modify datasets originating from parties other than Megagon are governed by the respective third party’s license conditions. 

You agree that Megagon grants no license as to any of its intellectual property and patent rights.  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS (INCLUDING MEGAGON) “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. You agree to cease using, incorporating, and distributing any part of the provided materials if you do not agree with the terms or the lack of any warranty herein.

While Megagon makes commercially reasonable efforts to ensure that citations in this document are complete and accurate, errors may occur. If you see any error or omission, please help us improve this document by sending information to contact_oss@megagon.ai.

## Open Source Software (OSS) Components 

All OSS components used within the product are listed below (including their copyright holders and the license information).

For OSS components having different portions released under different licenses, please refer to the included Upstream link(s) specified for each of the respective OSS components for identifications of code files released under the identified licenses.

</br>

| ID  | OSS Component Name | Modified | Copyright Holder | Upstream Link | License  |
|-----|----------------------------------|----------|------------------|-----------------------------------------------------------------------------------------------------------|--------------------|
| 1 | async-timeout | No | aio-libs collaboration | [link](https://github.com/aio-libs/async-timeout) | Apache Software License | 
| 2 | bidict | No | Joshua Bronson | [link](https://github.com/jab/bidict) | Mozilla Public License 2.0 | 
| 3 | blinker | No | Jason Kirtland | [link](https://github.com/pallets-eco/blinker/) | MIT License | 
| 4 | click | No | Pallets | [link](https://github.com/pallets/click/) | BSD License | 
| 5 | dnspython | No | Dnspython Contributors | [link](https://www.dnspython.org/) | ISC License | 
| 6 | eventlet | No | Eventlet Contributors, Linden Research, Inc. | [link](https://github.com/eventlet/eventlet) | MIT License | 
| 7 | Flask | No | Pallets | [link](https://github.com/pallets/flask/) | BSD License | 
| 8 | Flask-SocketIO | No | Miguel Grinberg | [link](https://github.com/miguelgrinberg/flask-socketio) | MIT License | 
| 9 | greenlet | No | Armin Rigo, Christian Tismer and contributors | [link](https://greenlet.readthedocs.io/en/latest/) | MIT License | 
| 10 | gunicorn | No | Benoît Chesneau <benoitc@gunicorn.org> | [link](https://gunicorn.org/) | MIT License | 
| 11 | importlib-metadata | No | Jason R. Coombs | [link](https://github.com/python/importlib_metadata) | Apache Software License | 
| 12 | itsdangerous | No | Pallets | [link](https://github.com/pallets/itsdangerous/) | BSD License | 
| 13 | Jinja2 | No | Pallets | [link](https://github.com/pallets/jinja/) | BSD License | 
| 14 | jsonmerge | No | Tomaz Solc | [link](https://pypi.org/project/jsonmerge/) | MIT License | 
| 15 | jsonpath-ng | No | Tomas Aparicio | [link](https://github.com/h2non/jsonpath-ng) | Apache Software License | 
| 16 | jsonschema | No | Julian Berman | [link](https://github.com/python-jsonschema/jsonschema) | MIT License | 
| 17 | MarkupSafe | No | Pallets | [link](https://github.com/pallets/markupsafe/) | BSD License | 
| 18 | psutil | No | Jay Loden, Dave Daeschler, Giampaolo Rodola | [link](https://github.com/giampaolo/psutil) | BSD License | 
| 19 | pydash | No | Derrick Gilland | [link](https://github.com/dgilland/pydash) | MIT License | 
| 20 | python-engineio | No | Miguel Grinberg | [link](https://github.com/miguelgrinberg/python-engineio) | MIT License | 
| 21 | python-socketio | No | Miguel Grinberg | [link](https://github.com/miguelgrinberg/python-socketio) | MIT License | 
| 22 | redis | No | Redis, inc. | [link](https://github.com/redis/redis-py) | MIT License | 
| 23 | rpyc | No | Tomer Filiba | [link](https://rpyc.readthedocs.org/) | MIT License | 
| 24 | six | No | Benjamin Peterson | [link](https://github.com/benjaminp/six) | MIT License | 
| 25 | tqdm | No | noamraph | [link](https://github.com/tqdm/tqdm) | MIT License | 
| 26 | uuid | No | Ka-ping Yee | [link](http://zesty.ca/python/) | Python software license | 
| 27 | websockets | No | Aymeric Augustin and contributors | [link](https://github.com/python-websockets/websockets) | BSD License | 
| 28 | Werkzeug | No | Pallets | [link](https://github.com/pallets/werkzeug/) | BSD License | 
| 29 | zipp | No | Jason R. Coombs | [link](https://github.com/jaraco/zipp) | MIT License | 