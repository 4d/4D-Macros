<!-- MARKDOWN LINKS & IMAGES -->
[release-shield]: https://img.shields.io/github/v/release/4D/4D-Macros.svg?include_prereleases
[release-url]: https://github.com/4D/4D-Macros.svg/releases/latest

[license-shield]: https://img.shields.io/github/license/4D/4D-Macros.svg

<!--BADGES-->
![Static Badge](https://img.shields.io/badge/Dev%20Component-blue?logo=4d&link=https%3A%2F%2Fdeveloper.4d.com)
![Static Badge](https://img.shields.io/badge/Project%20Dependencies-blue?logo=4d&link=https%3A%2F%2Fdeveloper.4d.com%2Fdocs%2FProject%2Fcomponents%2F%23loading-components)
<br>
[![release][release-shield]][release-url]
[![license][license-shield]](LICENSE)
<br>
<img src="https://img.shields.io/github/downloads/4D/4D-Macros/total"/>

# <a name="overview">Overview</a>

When this component is installed and loaded into your project, [its macros](#macros) are automatically available in the code editor and can be [invoked](https://developer.4d.com/docs/code-editor/write-class-method/#calling-macros):

* By clicking on the [Macros button](https://developer.4d.com/docs/code-editor/write-class-method#toolbar) on the code editor toolbar.
* By double-clicking on their name in one of the [footer lists](https://developer.4d.com/docs/code-editor/write-class-method#lists-area) of the method editor.
* For some of them, by selecting the name of the macro in the `“Method”` > `“Insert Macro”` submenu, or in the `“Insert Macro”` submenu of the editing zone context menu.
* For some, in the predictive input window.

For more information on the use and operation of macros, you can refer to the [4D documentation](https://developer.4d.com/docs/code-editor/write-class-method/#macros).

# Installation

## ![Static Badge](https://img.shields.io/badge/Project%20Dependencies-blue?logo=4d&link=https%3A%2F%2Fdeveloper.4d.com%2Fdocs%2FProject%2Fcomponents%2F%23loading-components)

This component is compatible with the [Project dependencies](https://developer.4d.com/docs/Project/components#monitoring-project-dependencies) feature. So you can simply integrate this component into your project by selecting `Design` > `Project dependencies` and adding `4d/4d-macros` as the GitHub® repository address in the dedicated dialog box. 

>📍The project's dependency manager ensures that you are always using the latest available version of the components.

## Earlier versions of 4D or binary database

1. Create a `Components` folder next to the `Project` folder of your database \*.
2. Place the `4D Macros.4dbase` component \** in this `Components` folder.

	\* For a binary database, the `Components` folder must be located next to the structure file of your database (".4db").    
	\** On `macOS`, the component is a package whose ".4dbase" extension is not necessarily visible depending on your display preference settings.

>📍It is always preferable to use an alias file (macOS®) or shortcut file (Windows®) instead of the component and thus store the originals in a single copy. Updates will be simplified especially if you maintain several projects. 

# <a name="macros">Published macros</a>

| Name | Goal | 
|:-----|:-----|
| [C_xxx -> var](#toVar) | Replaces the deprecated instructions “**C_xxx**(...)” with the new syntax “**var** ... : **type**”. 

## <a name="toVar">C_xxx -> var</a>

After calling this macro, for the entire method, deprecated declaration statements such as **C_LONGINT**(…)\*, **C_TEXT**(…)\*, **C_BLOB**(…)\* ... are replaced by the new syntax **var** ... : **Integer**, **var** ... : **Text**, **var** ... : **Blob** …


>📍 The lines **C_xx** (  ***\<method>***;  $… )\*\* & the comments are not modified


\* With 20R7+, **C_xxx** commands are preceded by the obsolete marking prefix and are displayed as **\_O\_C_xxx**.

\*\* The **C_xx** ( ***\<method>*** ; $... ) declarations used in `COMPILER_xxx` methods to define parameters and returns for project methods are obsolete. The use of the syntax [#DECLARE](https://developer.4d.com/docs/Concepts/parameters/#declaring-parameters) dispenses with these declarations.


For example :

```4d
_O_C_TEXT(vDetail)// _O_C_TEXT(vMessage)_O_C_LONGINT(vError)_O_C_LONGINT(myMethod; $0)
```

will be transformed into:

```4d
var vDetail : Text// _O_C_TEXT(vMessage)var vError : Integer_O_C_LONGINT(myMethod; $0)
```

# <a name="improvment">Improvements and bug fixes</a>

If you encountered a bug or have a feature request, feel free to create an issue.
However, it is highly appreciated if you <a href="https://github.com/4d/4d-macros/issues" target="_blank">browse and search current issues</a> first.
Found the issue? Go on and join its discussion thread.
Not found? Go on and <a href="https://github.com/4d/4d-macros/issues/new" target="_blank">create one</a>.

It is strongly recommended that you create a [clone of this repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) and do a [pull-request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) for your improvements and bug fixes.
