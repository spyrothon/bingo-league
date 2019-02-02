import _ from 'lodash';
import { h, Component } from 'preact';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

export class TwitchEmbed extends Component {
  render(props) {
    const {
      channel,
      width=858,
      height=480,
      frameBorder=0,
      enableScrolling=false,
      allowFullscreen=true,
      autoplay=true,
      muted=true,
      time=null
    } = props;

    return (
      <iframe
          src={`https://player.twitch.tv/?channel=${channel}`}
          height={height}
          width={width}
          frameborder={frameBorder}
          scrolling={enableScrolling ? "yes" : "no"}
          allowfullscreen={allowFullscreen ? true : false}
          muted={muted}
          time={time}
        ></iframe>
    );
  }
};
