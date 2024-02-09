@module("lodash")
external min: array<'a> => 'a = "min"

@module("lodash")
external max: array<'a> => 'a = "max"

@module("lodash")
external flatten: array<'a> => array<'b> = "flatten"

@module("lodash")
external capitalize: string => string = "capitalize"

@module("lodash")
external isEqual: ('a, 'b) => bool = "isEqual"

@module("lodash")
external lowerCase: string => string = "lowerCase"

// Prefer Js.String.toUpperCase since Lodash.toUpper will strip out special chars and add spaces between strings and numbers - Cid
// @module("lodash")
// external upperCase: string => string = "upperCase"

@module("lodash")
external toUpper: string => string = "toUpper"

@module("lodash")
external sortBy: (array<'a>, 'a => 'b) => array<'a> = "sortBy"

@module("lodash")
external orderBy: (array<'a>, option<array<'b>>, string) => array<'a> = "orderBy"

@module("lodash")
external uniqBy: (array<'a>, 'a => 'b) => array<'a> = "uniqBy"

@module("lodash")
external uniq: (array<'a>) => array<'a> = "uniq"

@module("lodash")
@variadic
external zipArray: (array<array<'a>>) => array<array<'a>> = "zip"

@module("lodash")
external zip2: (array<'a>, array<'b>) => array<(Js.Undefined.t<'a>, Js.Undefined.t<'b>)> = "zip"

// You assert that the array lengths are equal - AxM
@module("lodash")
external zip2Equal: (array<'a>, array<'b>) => array<('a, 'b)> = "zip"

@module("lodash")
external zip3: (
  array<'a>,
  array<'b>,
  array<'c>,
) => array<(Js.Undefined.t<'a>, Js.Undefined.t<'b>, Js.Undefined.t<'c>)> = "zip"

@module("lodash")
external zip3Equal: (array<'a>, array<'b>, array<'c>) => array<('a, 'b, 'c)> = "zip"

@module("lodash")
external unzip2: array<('a, 'b)> => (array<'a>, array<'b>) = "unzip"

@module("lodash")
external unzip3: array<('a, 'b, 'c)> => (array<'a>, array<'b>, array<'c>) = "unzip"

type optsDebounce = {
  leading: option<bool>,
  trailing: option<bool>,
  maxWait: option<float>,
}

let makeOptsDebounce = (~leading=?, ~trailing=?, ~maxWait=?, ()) => {
  leading,
  trailing,
  maxWait,
}

// WARNING: curried debounces are not going to work like you think - AxM
// Prefer an uncurried debounce called in a callback. e.g.

// @module("lodash")
// external debounce0: (unit => 'c, int, optsDebounce, unit) => 'c = "debounce"

// @module("lodash")
// external debounce1: ('a => 'c, int, optsDebounce, 'a) => 'c = "debounce"
// @module("lodash")
// external debounce2: (('a, 'b) => 'c, int, optsDebounce, 'a, 'b) => 'c = "debounce"

// TODO: Separating the toOption->getWithDefault pipeline to its own function causes errors? -AxM
// CAUTION: These functions return an uncurried function.
// Autoformatting may put the arguments for this returned function into
// the first list of args which is confusing
@module("lodash")
external debounce0U: (@uncurry (unit => 'c), int, optsDebounce, . unit) => Js.Undefined.t<'c> =
  "debounce"

let debounce0UD = (fn, time, opts, default) => {
  let d = debounce0U(fn, time, opts)
  (. ()) => {d(.)->Js.Undefined.toOption->Belt.Option.getWithDefault(default)}
}

@module("lodash")
external debounce1U: (@uncurry ('a => 'c), int, optsDebounce, . 'a) => Js.Undefined.t<'c> =
  "debounce"

let debounce1UD = (fn, time: int, opts: optsDebounce, default: 'c) => {
  let debounced = debounce1U(fn, time, opts)
  (. a) => {debounced(. a)->Js.Undefined.toOption->Belt.Option.getWithDefault(default)}
}

@module("lodash")
external debounce2U: (@uncurry ('a, 'b) => 'c, int, optsDebounce, . 'a, 'b) => Js.Undefined.t<'c> =
  "debounce"

let debounce2UD = (fn, time: int, opts: optsDebounce, default: 'c) => {
  let debounced = debounce2U(fn, time, opts)
  (. a, b) => {debounced(. a, b)->Js.Undefined.toOption->Belt.Option.getWithDefault(default)}
}

@module("lodash")
external debounce3U: (
  @uncurry ('a, 'b, 'c) => 'd,
  int,
  optsDebounce,
  . 'a,
  'b,
  'c,
) => Js.Undefined.t<'d> = "debounce"

let debounce3UD = (fn, time: int, opts: optsDebounce, default: 'd) => {
  let debounced = debounce3U(fn, time, opts)
  (. a, b, c) => {debounced(. a, b, c)->Js.Undefined.toOption->Belt.Option.getWithDefault(default)}
}
