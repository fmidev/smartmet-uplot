# smartmet-uplot

RPM repackaging of the [uPlot](https://github.com/leeoniya/uPlot) chart library
(`uplot` npm package) for SmartMet Server.

The data explorer of SmartMet Server (`/api/explorer`) draws time series charts
with uPlot. The JavaScript and CSS files are installed to
`/usr/share/smartmet/uplot` and served by the server itself, so the explorer
works without access to any public CDN.

    make rpm      # download the source tarball and build the RPM
    make unpack   # extract the installed file set into ./dist for local tests
