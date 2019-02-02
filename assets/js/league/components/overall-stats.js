import _ from 'lodash';
import { h, Component } from 'preact';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

export class OverallStats extends Component {
  render(props) {
    const {
      matches,
      allTeams
    } = props;

    const plays = _.chain(matches)
        .map('plays')
        .flatten()
        .value();

    const matchCount = matches.length;
    const teamCount = Object.values(allTeams).length;
    const goalCount = _.sumBy(plays, 'score');

    const featuredMatchCount = _.filter(matches, 'is_featured').length;

    return (
      <div class="overall-stats">
        <p class="is-size-7">
          <strong> {teamCount} </strong>
          teams have played in
          <strong> {matchCount} </strong>
          matches, collecting a total of
          <strong> {goalCount} </strong>
          goals.
        </p>
        <p class="is-size-7">
          <strong> {featuredMatchCount} </strong>
          of those matches were featured live on the
          <a href="https://twitch.tv/spyrothon" target="_blank"> Spyrothon Twitch Channel</a>.
        </p>
      </div>
    );
  }
};
