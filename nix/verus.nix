{
  lib,
  stdenv,
  fetchurl,
  unzip,
  makeWrapper,
  autoPatchelfHook,
  zlib,
  rustToolchain,
}:
let
  version = "0.2026.10.18.7d82994";
  archives = {
    x86_64-linux = {
      platform = "x86-linux";
      sha256 = "e9af03732d4bdd32b93a8fcf471706739c24c1473fa5086618d96c47237845dd";
    };
    aarch64-darwin = {
      platform = "arm64-macos";
      sha256 = "3fc56c58277b5f0999368f7b3a2b07ba4eb9ec2965454ce7a9f2769c0464d32b";
    };
    x86_64-darwin = {
      platform = "x86-macos";
      sha256 = "503c50d82bc7588f5557eb4927ff1e2d523997d770b84267a4e5886d0d6f025f";
    };
  };
  archive = archives.${stdenv.hostPlatform.system};
  loaderVariable = if stdenv.isDarwin then "DYLD_LIBRARY_PATH" else "LD_LIBRARY_PATH";
in
stdenv.mkDerivation {
  pname = "terrane-verus";
  inherit version;
  src = fetchurl {
    url = "https://github.com/verus-lang/verus/releases/download/release/${version}/verus-${version}-${archive.platform}.zip";
    inherit (archive) sha256;
  };

  nativeBuildInputs = [
    unzip
    makeWrapper
  ]
  ++ lib.optionals stdenv.isLinux [ autoPatchelfHook ];
  buildInputs = [
    rustToolchain
    zlib
  ]
  ++ lib.optionals stdenv.isLinux [ stdenv.cc.cc.lib ];
  dontConfigure = true;
  dontBuild = true;
  dontStrip = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/libexec/verus" "$out/bin"
    for file in rust_verify z3 vstd.vir libvstd.rlib version.json \
      libverus_builtin.rlib \
      libverus_builtin_macros${stdenv.hostPlatform.extensions.sharedLibrary} \
      libverus_state_machines_macros${stdenv.hostPlatform.extensions.sharedLibrary}; do
      cp "$file" "$out/libexec/verus/"
    done
    makeWrapper "$out/libexec/verus/rust_verify" "$out/bin/terrane-verus" \
      --set VERUS_Z3_PATH "$out/libexec/verus/z3" \
      --prefix ${loaderVariable} : "${rustToolchain}/lib" \
      --prefix PATH : "${lib.makeBinPath [ rustToolchain ]}" \
      --add-flags "--sysroot ${rustToolchain}"
    runHook postInstall
  '';

  meta = {
    description = "Pinned Verus verifier for Terrane";
    homepage = "https://github.com/verus-lang/verus";
    license = lib.licenses.mit;
    platforms = builtins.attrNames archives;
    mainProgram = "terrane-verus";
  };
}
