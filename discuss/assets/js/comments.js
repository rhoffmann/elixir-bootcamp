import { Socket } from "phoenix";

let socket = new Socket("/socket", {
  params: { token: window.userToken }
});

socket.connect();

const createSocket = ({ topicId = null } = {}) => {
  // Now that you are connected, you can join channels with a topic:
  let channel = socket.channel(`comments:${topicId}`, {});

  channel
    .join()
    .receive("ok", resp => {
      console.log("Joined successfully", resp);
    })
    .receive("error", resp => {
      console.log("Unable to join", resp);
    });

  return channel;
}

window.createSocket = createSocket;
