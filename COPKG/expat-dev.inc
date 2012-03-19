@import "version.inc" ;
@import "outercurve.inc" ;

package {
    name: "expat-dev[${flavor}]";
    version: "${package-version}";
    arch : "${arch}";

    display-name: "Expat Developer library";
}

metadata {
    summary: "The Expat developer library";
    description: @"Expat is an XML parser library written in C. It is a stream-oriented parser in which an application registers handlers for things the parser might find in the XML document."; 

    icon: @"expat.png";
    
    author-version : "2.0.1";
    bug-tracker: "https://github.com/coapp-packages/expat/issues";
    stability : "0";
    licenses : {
        MIT
    };
}

files[libs] {
    root: @"..\win32\bin\${arch}\Release\";
    
    include: {
        "libexpatMT.lib",
		"libexpat.lib",
		"libexpatwMT.lib",
		"libexpatw.lib",
    };
    
    trim-path: all;
};

requires {
    package: "expat-dev-common-${package-version}-any-${Package.PublicKeyToken}";
    package: "expat[${flavor}]-${package-version}-${Package.Architecture}-${Package.PublicKeyToken}";
}

developer-library[expat] {
    libraries : {
        libs
    };
}