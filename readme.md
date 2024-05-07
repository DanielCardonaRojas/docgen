# Generate documents 

Create documents like invoices from structured data in formats such as json.

Output files can be any format supported by pandoc, not just markdown and html.

## Requirements

- [gomplate](https://docs.gomplate.ca/)
- [gum](https://github.com/charmbracelet/gum)
- [pandoc](https://pandoc.org/)

## Usage

Create a folder with the following structure in `~/.config/docgen` for the document type
you want to create. This can be achieved running: `make scaffold`


```sh
invoice
├── data
│   └── company1.json
│   └── company2.json
└── templates
    ├── bold.html
    └── bold.md

```

**Generate doc**

Once you have created a template and values to populate it (`templates/` and `data/` respectively), then run.

```sh
make generate
```

this will run an interactive selections to generate the document you want.


```




