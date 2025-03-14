# Steps for adding new documents to ReadTheDocs:

## Add a new document
- clone the repo from 
	- https://gitlab.com/ska-telescope/ska-mid-cbf-deployment

- create new folder in ska-mid-cbf-deployment/docs
    - eg: ska-mid-cbf-deployment/docs/api

- at the bottom of the ska-mid-cbf-deployment/docs/index.rst add a new section for api docs eg:

    ```
	.. toctree::
  	  :maxdepth: 2
          :caption: <api section title>
          :hidden:

  	  api/<api_doc_1.md>
  	  api/<api_doc_2.md>
    ```

- Run the following:
    ```
	poetry lock
	poetry install
    ```

## Building ReadTheDocs Locally
- To generate the documentation, navigate into `ska-mid-cbf-deployment/docs` and run:
    ```
	poetry run make html
    ```

    or if in a poetry virtualenv, run
    ```
	make html
    ```

- The generated docs can be found in `ska-mid-cbf-deployment/docs/build`.

- Open `index.html` in your browser to view the documentation.
