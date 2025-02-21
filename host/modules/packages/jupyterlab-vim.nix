{ lib
, buildPythonPackage
, fetchPypi
, hatchling
, hatch-jupyter-builder
, hatch-nodejs-version
, jupyterlab
}:

buildPythonPackage rec {
  pname = "jupyterlab-vim";
  version = "4.1.4";
  pyproject = true;

  src = fetchPypi {
    pname = "jupyterlab_vim";
    inherit version;
    hash = "sha256-q/KJGq+zLwy5StmDIa5+vL4Mq+Uj042A1WnApQuFIlo=";
  };

  nativeBuildInputs = [
    hatchling
    hatch-jupyter-builder
    hatch-nodejs-version
  ];

  propagatedBuildInputs = [ jupyterlab ];
  pythonImportsCheck = [ "jupyterlab_vim" ];

  doCheck = false;

  meta = with lib; {
    description = "Vim notebook cell bindings for JupyterLab";
    homepage = "https://github.com/jupyterlab-contrib/jupyterlab-vim";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [ ];
  };
}
