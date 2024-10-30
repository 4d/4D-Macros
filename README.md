<!-- MARKDOWN LINKS & IMAGES -->
[release-shield]: https://img.shields.io/github/v/release/4D/4D-Macros.svg?include_prereleases
[release-url]: https://github.com/4D/4D-Macros.svg/releases/latest

[license-shield]: https://img.shields.io/github/license/4D/4D-Macros.svg

<!--BADGES-->
![Static Badge](https://img.shields.io/badge/Dev%20Component-blue?logo=4d&link=https%3A%2F%2Fdeveloper.4d.com)
![Static Badge](https://img.shields.io/badge/Project%20Dependencies-blue?logo=4d&link=https%3A%2F%2Fdeveloper.4d.com%2Fdocs%2FProject%2Fcomponents%2F%23loading-components)
<br>
[![release][release-shield]][release-url]
<img src="https://img.shields.io/github/downloads/4D/4D-Macros/total"/>

# <a name="overview">Overview</a>

The 4D-Macros component provides convenient macros that enhance code editing in 4D’s code editor. 

Once installed, [these macros](#macros) are available directly in the editor, where you can use them to simplify tasks, convert code syntax, ensure consistent formatting, …. 

> 💡 [Macros can be called](https://developer.4d.com/docs/code-editor/write-class-method/#calling-macros):
><br>           - By clicking on the [Macros button](https://developer.4d.com/docs/code-editor/write-class-method#toolbar) on the code editor toolbar.
><br>           - By double-clicking on their name in one of the [footer lists](https://developer.4d.com/docs/code-editor/write-class-method#lists-area) of the method editor.
><br>           - For some of them, by selecting the name of the macro in the `“Method”` > `“Insert Macro”` submenu, or in the `“Insert Macro”` submenu of the editing zone context menu.
><br>           - For some, in the predictive input window.

For more information on the use and operation of macros, you can refer to the [4D documentation](https://developer.4d.com/docs/code-editor/write-class-method/#macros).

# Installation

## Compatibility with Project Dependencies

This component is fully compatible with [4D's Project dependencies](https://developer.4d.com/docs/Project/components#monitoring-project-dependencies) feature. You can add the component to your project by selecting `Design` > `Project dependencies` and adding `4d/4d-macros` as the GitHub® repository address in the dedicated dialog box. 

>📍The project's dependency manager ensures that you are always using the latest available version of the components.

## Installing for Older Versions or Binary Databases

1. Create a `Components` folder alongside your `Project` folder \*.
2. Place the `4D Macros.4dbase` component \** into this `Components` folder.

	\* For binary databases: Locate the `Components` folder next to the structure file (.4db).  
	\** On `macOS`, the component is a package whose ".4dbase" extension is not necessarily visible depending on your display preference settings.

>📍Using an alias (macOS®) or shortcut (Windows®) file is recommended for easier updates across multiple projects.

# <a name="macros">Available Macros</a>

| Name | Goal | 
|:-----|:-----|
| [C_xxx -> var](#toVar) | Replaces the deprecated commands like “**C_xxx**(...)” with the new “**var** ... : **type**” syntax. 

## • <a name="toVar">_C\_xxx -> var_</a>

ℹ️ ***This macro is automatically executed when you open a method.***

The deprecated declarations such a **C_LONGINT**(…)\*, **C_TEXT**(…)\*, **C_BLOB**(…)\* ... are replaced by the new syntax **var** ... : **Integer**, **var** ... : **Text**, **var** ... : **Blob** …

Example transformation:

**Before:**

```4d
_O_C_LONGINT($1)
_O_C_TEXT(${2})

_O_C_TEXT(vDetail; $message)
// _O_C_TEXT(vMessage)
_O_C_LONGINT(vError)

_O_C_LONGINT(myMethod; $0)
```

**After**:

```4d
var $1 : Integer
_O_C_TEXT(${2})

var vDetail; $message : Text
// _O_C_TEXT(vMessage)
var vError : Integer

_O_C_LONGINT(myMethod; $0)
```
 
>📍 The lines **C_xx** (  ***\<method>***;  $… )\*\* & the comments are not modified, nor the syntax **C_xx** (${n})\*\*\*

<br>\* With 20R7+, **C_xxx** commands are preceded by the obsolete marking prefix and are displayed as **\_O\_C_xxx**.
<br>\*\* The **C_xx** ( ***\<method>*** ; $... ) declarations used in `COMPILER_xxx` methods to define parameters and returns for project methods are obsolete. The use of the syntax [#DECLARE](https://developer.4d.com/docs/Concepts/parameters/#declaring-parameters) dispenses with these declarations.
<br>\*\*\* This syntax, which allows you to declare a variable number of parameters of the same type, is also deprecated and must be replaced by the use of the syntax [#DECLARE](https://developer.4d.com/docs/Concepts/parameters/#declaring-parameters)

# <a name="improvment">Improvements and Bug Fixes</a>

If you encounter a bug or have a feature request, feel free to <a href="https://github.com/4d/4d-macros/issues" target="_blank">browse and search existing issues</a>. If you don't find your issue listed, go ahead and <a href="https://github.com/4d/4d-macros/issues/new" target="_blank">create a new one</a>.

For those contributing directly, it’s recommended to:

> 1- [Clone the repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository).
    
> 2- Make modifications and submit a [pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests).
