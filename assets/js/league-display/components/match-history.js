import { h, Component } from 'preact';
import MatchContainer from '../containers/match-container';

class MatchHistory extends Component {
  render(props) {
    const { matches } = props;

    return (
      <div class="matches">
        { matches.map((match) => (
            <MatchContainer match={match} />
          ))
        }
      </div>
    );
  }
};

export default MatchHistory;
