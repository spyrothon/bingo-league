import { h, Component } from 'preact';

class TeamStandings extends Component {
  render(props) {
    const { teams } = props;

    return (
      <ul>
        { teams.map((team) => (
            <li>
              <a href={`/teams/${team.id}`}>{team.name}</a>
            </li>
          ))
        }
      </ul>
    );
  }
}

export default TeamStandings;
