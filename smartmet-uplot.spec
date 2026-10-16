#
# uPlot static files for the SmartMet Server data explorer.
#
# The data explorer (/api/explorer) draws time series with uPlot, a small and
# fast chart library. The files are installed locally and served by the server
# itself, so the explorer does not depend on any public CDN.
#
# The source is the upstream uplot npm package. Only the minified browser
# build, its stylesheet and the license are installed.
#
# Sources are downloaded, not stored in the repository:
#
#   make sources
#   make rpm
#
# To update: change Version to a uplot release at least two weeks old, then
# rebuild.
#

%global upstream uplot

Name:           smartmet-uplot
Version:        1.6.31
Release:        1%{?dist}.fmi
Summary:        uPlot static files for the SmartMet Server data explorer
License:        MIT
URL:            https://github.com/leeoniya/uPlot
Source0:        https://registry.npmjs.org/%{upstream}/-/%{upstream}-%{version}.tgz
BuildArch:      noarch

%description
uPlot %{version} browser build, installed to %{_datadir}/smartmet/uplot.
The SmartMet Server data explorer uses it to draw time series charts.

%prep
%setup -q -n package

%build
# Nothing to build; the npm package contains the prebuilt browser build.

%install
mkdir -p %{buildroot}%{_datadir}/smartmet/uplot
install -m 0644 dist/uPlot.iife.min.js %{buildroot}%{_datadir}/smartmet/uplot/uPlot.iife.min.js
install -m 0644 dist/uPlot.min.css %{buildroot}%{_datadir}/smartmet/uplot/uPlot.min.css

%files
%license LICENSE
%dir %{_datadir}/smartmet
%{_datadir}/smartmet/uplot

%changelog
* Fri Oct 16 2026 Mika Heiskanen <mika.heiskanen@fmi.fi> - 1.6.31-1.fmi
- Initial package: uplot 1.6.31 for the SmartMet Server data explorer
