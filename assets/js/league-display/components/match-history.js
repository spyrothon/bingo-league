import { h, Component } from 'preact';

class MatchHistory extends Component {
  render(props) {
    const { matches } = props;

    return (
      <table class="table is-fullwidth">
        <thead>
          <tr>
            <th>Name</th>
            <th>Player Count</th>
          </tr>
        </thead>

        <tbody>
          { matches.map((match) => (
              <tr>
                <td>{match.name}</td>
                <td>{match.plays.length}</td>
              </tr>
            ))
          }
        </tbody>
      </table>
    );
  }
};

export default MatchHistory;
