module.exports = {
    // configureYulOptimizer: true, // (Experimental). Should resolve "stack too deep" in projects using ABIEncoderV2.
    skipFiles: ["interfaces/", "mock/", "from-dependencies/", "erc721a/", "AvaxApes.sol"],
    mocha: {
        fgrep: "[skip-on-coverage]",
        invert: true
    }
};
