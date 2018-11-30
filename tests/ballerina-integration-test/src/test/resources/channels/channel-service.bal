import ballerina/http;

listener http:Listener server {
    port:9600
};

channel<json> chn;

@interruptible
service channelService on server {

    resource function receiveChannelMessage (http:Caller caller, http:Request request) {

        http:Response response = new;
        json result;
        map<any> key = { line1: "No. 20", line2: "Palm Grove", city: "Colombo 03", country: "Sri Lanka" };
        result <- chn,key;
        response.setJsonPayload(result, contentType = "application/json");
        _ = caller -> respond(response);
    }


    resource function sendChannelMessage (http:Caller caller, http:Request request) {

        // Create object to carry data back to caller
        http:Response response = new;

        json result = {message:"channel_message"};
        map<any> key = { line1: "No. 20", line2: "Palm Grove", city: "Colombo 03", country: "Sri Lanka" };
        result -> chn,key;

        response.setJsonPayload(result, contentType = "application/json");
        _ = caller -> respond(response);
    }
}
