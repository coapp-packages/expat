compatability-policy {
    minimum: "2.0.1";
    maximum: "${OneLessThanCurrent}"; // this is the default
    versions : {
        "2.0",
    }; // if not specified, find the versions by looking at the feeds and finding all the major/minor versions in range.
}

 
