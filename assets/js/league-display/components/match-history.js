import { h, Component } from 'preact';
import MatchContainer from '../containers/match-container';

class MatchHistory extends Component {
  render(props) {
    const { matches } = props;

    console.log(matches)

    const sortedMatches = matches.sort((a, b) => b.start_date.localeCompare(a.start_date));

    return (
      <div class="matches">
        { sortedMatches.map((match) => (
            <MatchContainer match={match} />
          ))
        }
      </div>
    );
  }
};

export default MatchHistory;
