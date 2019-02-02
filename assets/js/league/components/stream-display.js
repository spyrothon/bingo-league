import _ from 'lodash';
import { h, Component } from 'preact';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { TwitchEmbed } from "./twitch-embed";

export class StreamDisplay extends Component {
  getThumbnailURL(template, {width=858, height=480}) {
    return template
        .replace("{width}", width)
        .replace("{height}", height);
  }

  render(props) {
    const {
      loading,
      channelName,
      channelData
    } = props;

    const isLive = !loading && channelData;

    if(!isLive) return null;

    const {
      title,
      thumbnail_url,
      viewer_count,
      user_name
    } = channelData;

    return (
      <div class="stream-display has-margin-top-lg">
        <div class="stream-banner">
          {user_name} is streaming right now!
        </div>
        <TwitchEmbed channel={channelName} layout="video" />
      </div>
    );
  }
};
