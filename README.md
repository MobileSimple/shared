# shared

## Overlay

Provider support for overlay, make it easy to build toast, In-App notification, bottom cards and many more.

- [Overlay](https://github.com/MobileSimple/shared/tree/main/lib/overlay)

***IMPORTANT: for overlay to be working propery include 'Scaffold(..)" in yor widget tree***

Possible calls of overlay:

`await showText(context, text, {buttons, backgrounpTap, duration})`

`await showText(context, text, {buttons, backgrounpTap, duration})`

`await showTitleText(context, title, text, {buttons, backgrounpTap, duration})`

`bool await showConfirm(context, title, text)`

`await showCustom(context, child, {identifier, backgroundTap})`

`await showItems(context, items, itemWidget, {identifier, backgroundTap})`

`await showItemsFuture(context, itemsFuture, itemWidget, {identifier, backgroundTap})`

`await showError(context, text, {backgroundTap, duration})`

`await showNotification(context, text, {backgroundTap, durarion})`

`await intercept(context, {identifier})`

`await showToast(context, text, {duration})`

`void hide(identifier)`

`bool hideLast()`

`void hideAll()`

>**Main method for showing overlay**
>
>```dart
>await show(
>   context,
>   body,
>   {
>      identifier,
>      title,
>      text,
>      textStyle,
>      child,
>      buttons,
>      onBackgorund,
>      items,
>      itemsFuture,
>      itemWidet,
>      color,
>      opacity,
>      duration
>    }
>```

Additionals functions:

- Overlay can be stacked on top itself (many layers)
- Use identifier in order to hide specific overlay
- To intercept backbutton (pop to previus) and hide visible ovelray or block it use:
```dart
  WillPopScope(
        onWillPop: () => Future.value(!overlay.hideLast()),
        child: Scaffold(...),
  )
```
- When using 'TextField(...)' function **intercept()** can be used for capturing all input other than keyboard (note: use identifier to let overlay now which one to close)
```dart
  TextField(
    onTap: () => overlay.intercept(context, identifier: 'hide_text_field'),
    onSubmitted: (_) => overlay.hide('hide_text_field'),
  ),
```



## Constants

Constants value for app use.
