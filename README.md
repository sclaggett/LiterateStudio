# LiterateStudio

*LiterateStudio* is a development environment for literate programming. I decided to create it after searching for a WYSIWYG editor for Markdown files and failing to find any that provided the quick and efficient interface that I want when working on a large codebase.

## Design

The design of the application is heavily inspired by Sublime. The goal is to allow the viewing and editing of a web of Markdown files. It expects that you'll use your OS to to create, rename, move, and delete files and directories and a separate source control application.






App was initially created using the [Electron React Boilerplate](https://github.com/electron-react-boilerplate/electron-react-boilerplate).

**Development**

Start by setting up your system for Electron development as described [here](https://www.electronjs.org/docs/tutorial/development-environment).

Install yarn and clone the repository.

```sh
$ sudo npm install -g yarn
$ git clone git@github.com:sclaggett/LiterateStudio.git
$ cd LiterateStudio
```

Tangle the source, initialize dependencies, and start the application.

```sh
$ ./Tangle.sh
$ cd bin
$ yarn
$ yarn dev
```

