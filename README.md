# Road to Elm - Examples of Elm code

Visit any directory and execute `elm reactor`
and then click on the file name to see it in action.
In some cases you need to install certain elm packages.
Instructions to install elm package is mentioned below.

### Submitting a form in Elm

https://github.com/bigbinary/road-to-elm/tree/master/subitting-a-form

### JSON decoding in Elm

Before running `elm reactor` execute following command.

```
elm package install NoRedInk/elm-decode-pipeline
```

* [Decoder1](https://github.com/bigbinary/road-to-elm/blob/master/json-decoding/Decoder1.elm) - decode simple JSON
* [Decoder2](https://github.com/bigbinary/road-to-elm/blob/master/json-decoding/Decoder2.elm) - decode simple JSON in an array
* [Decoder3](https://github.com/bigbinary/road-to-elm/blob/master/json-decoding/Decoder3.elm) - decode simple JSON in an array inside a key
* [Decoder4](https://github.com/bigbinary/road-to-elm/blob/master/json-decoding/Decoder4.elm) - decode JSON using `at` and `field`
* [Decoder5](https://github.com/bigbinary/road-to-elm/blob/master/json-decoding/Decoder5.elm) - decode JSON when key has null value
* [Decoder6](https://github.com/bigbinary/road-to-elm/blob/master/json-decoding/Decoder6.elm) - decode JSON when once key is present and once when key is missing. Decode to default string.
* [Decoder7](https://github.com/bigbinary/road-to-elm/blob/master/json-decoding/Decoder7.elm) - decode JSON when once key is present and once when key is missing. Decode to Nothing if key is missing or value is null.


### Making http requests in Elm

Before running `elm reactor` execute following command.

```
elm package install elm-lang/http -y
```

* [Show response body](https://github.com/bigbinary/road-to-elm/blob/master/making-http-requests/2ShowResponseBody.elm)
* [Show full response](https://github.com/bigbinary/road-to-elm/blob/master/making-http-requests/3ShowWholeResponse.elm)

