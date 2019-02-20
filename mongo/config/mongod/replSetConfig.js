var config = {
    _id: "consuldemo",
    version: 1,
    members: [{
        _id: 0,
        host: "mongo_1:27017",
    }, {
        _id: 1,
        host: "mongo_2:27017",
    }, {
        _id: 2,
        host: "mongo_3:27017",
    }],
    settings: { 
        chainingAllowed: true 
    }
};
rs.initiate(config, { force: true });
rs.slaveOk();
db.getMongo().setReadPref("nearest");
