import { h, Component } from 'preact';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

export class RulesScreen extends Component {
  render(props) {
    return (
      <div class="content">
        <h1 class="title header">Rules</h1>

        <p>Below are the rules for the Spyrothon Bingo League. Any cases that are not explicitly described in this ruleset will be reviewed and the ruleset will be amended accordingly once a decision is made.</p>
        <p>
          If a rule is unclear or is not present in this ruleset, please request a clarification in the <a href="https://discord.gg/fCvfnfk">Spyrothon Discord</a>
        </p>

        <p>For a list of Bingo objectives and clarifications for each, visit <a href="/goals">The Goals Page</a>.</p>

        <h2>Hardware and Gameplay</h2>
        <ul>
          <li>All Sony consoles with official releases of Spyro 2 are allowed: PlayStation, PlayStation 2, PlayStation 3, PlayStation TV.</li>
          <li>Selected Emulators are allowed: ePSXe 1.9.0/1.9.25/2.0.0, Xebra, Mednafen.</li>
          <li>FDS is allowed for NTSC-U, PAL, and NTSC-J on consoles that provide it.</li>
          <li>Live footage via Twitch is required for all league matches.</li>
          <li>In-game cheats are not allowed.</li>
          <li>All players must start from the main menu. Races should start from a "New Game" save file (e.g., no starting with fireball). If a player does start with fireball or from a save the match must be restarted.</li>
          <li>Players must not skip the opening cutscenes. This gives all players time to look at the board and start planning their routes. If a member of any team skips the cutscene at any point the match must be restarted with the same bingo card.</li>
          <li>Emulator save states are not allowed.</li>
          <li>Memory Cards are allowed, but only saves created during the match can be loaded. Saving and quitting to the menu to resume the game is allowed.</li>
          <ul>
            <li>Example: A player jumps over the wall to reach Aquaria Towers and is unable to exit the area after leaving the level. They may save their game, quit to the menu, and resume the game to spawn at the start of Summer Forest and continue to play.</li>
          </ul>
          <li>Resetting the console/emulator entirely is allowed. Emulator save states to the main menu are not allowed.</li>
          <ul>
            <li>Example: The goal "Buy Climb & Headbash" is on the board, but all players already unlocked these abilities by other means (e.g., defeating Ripto), meaning they are unable to complete this goal. Players are allowed to reset their console and start a new game during the match to then attempt this goal.</li>
          </ul>
        </ul>

        <h2>Game Mode</h2>
        <ul>
          <li>This is Lockout Bingo, once an objective has been marked off that goal can not be marked by another player.</li>
          <li>You do not need to immediately mark off goals you have completed, but do so at your own risk. If another player completes and marks the goal before you mark it, it will be considered their point.</li>
          <li>You can use notepads/calculators to track your game progress, but it is your responsibility to keep these updated and accurate. Mismarked goals without correction will invoke a penalty (see "Mismarked Goals").</li>
          <li>
            Boards should be played to full completion. Even if the match has a decisive winner, the match is not finished until all goals are marked. These goals may help break ties in team rankings.
            <ul>
              <li>Example: Team A has marked 13 goals while Team B has only marked 7 goals, with 5 goals remain unmarked. Team A has decisively won the match, but both teams continue play to mark the remaining goals.</li>
            </ul>
          </li>
          <li>To complete a goal, an individual player must complete all of its requirements. Completion of a single goal can not be shared between players.</li>
          <ul>
            <li>Example: the goal "250 gems in both Zephyr and Shady Oasis" requires a single player to collect 250 gems from both levels. The requirement can not be split such that one player collects 250 gems in Zephyr and another collects 250 gems in Shady Oasis.</li>
          </ul>
        </ul>

        <h2>Mismarked Goals</h2>
        <ul>
          <li>A goal is considered "mismarked" if a player marks the goal before meeting all of its requirements.</li>
          <li>Mismarked goals that are not corrected within a reasonable reaction time (within 1 second) will be automatically awarded to the opposing team.</li>
          <li>Accidental mismarking of a goal as an occasional mistake will not be punished, so long as the mistake is corrected within a reasonable reaction time and does not occur frequently.</li>
          <li>Continued, frequent mismarking of goals in multiple matches will result in removal from the league.</li>
        </ul>

        <h2>Sportsmanship and Community</h2>
        <ul>
          <li>Good sportsmanship is expected from all players. All players should have a form of mutual respect for one another.</li>
          <li>Do not direct any anger with the game towards other players. Frustration with the game or a match result is fine, but should not cross into conflict with other players.</li>
          <li>Keep personal conflicts out of the Spyrothon Discord channel and the Spyrothon Twitch Chat.</li>
          <li>Stream sniping is not allowed. All matches are required to be streamed live and may be reviewed if a player is suspected of stream sniping the other team.</li>
          <li>Excessive disruptive or generally poor behavior with any of the above will result in removal from the league.</li>
          <li><strong>Update May 5th, 2019:</strong> bingosync.com allows multiple users to use the same display name. As it was not explicitly laid out in the rules, and despite common sense and precedent in the history of bingo games, this ability has been abused in a small number of matches. Because of those past matches and to maintain consistency across the League, the ruling will not change and duplicate names will remain allowed for the rest of the League. However:
          <ul>
            <li>Excessively abusive names may be considered a direct violation of good sportsmanship and be met with any consequences of that rule.</li>
            <li>Use of duplicate names may be considered as a factor when evaluating sportsmanship as a whole, but must not be the only factor in a decision.</li>
            <li>In the playoff round, players will be directly assigned display names by Staff, and names will be announced publicly.</li>
          </ul>
          </li>
        </ul>

        <h2>Availability</h2>
        <ul>
          <li>We have done our best to accommodate everyone when scheduling matches. From here, it is each player's responsibility to be available for their matches at the times they are scheduled.</li>
          <li>If a scheduling conflict arises, it is the player's responsibility to request a reschedule for their match. The player must coordinate with with all other players to find a new time for the match, then communicate the new time to an organizer for it to be rescheduled.</li>
          <li>We will work to accommodate occasional rescheduling, but it is not guaranteed that a match can be rescheduled successfully.</li>
          <li>When a scheduling conflict occurs and a match can not be rescheduled, the match will be considered a forfeit from the unavailable team, and the opposing team will be awarded the win and all 25 goals from the match.</li>
          <li>If a team forfeits more than 2 matches, they will be removed from the league.</li>
        </ul>

        <h2>League Removal</h2>
        <ul>
          <li>Though discouraged, teams may voluntarily drop out of the league if circumstances require it.</li>
          <li>Teams may also be forcefully removed from the league after violations of any of the above rules.</li>
          <li>If a team is removed from the league, all matches including that team will be discarded. This includes both matches that were already played, and matches that were still scheduled.</li>
        </ul>

        <h2>Team Ranking</h2>
        <ul>
          <li>Teams are ranked by number of matches won.</li>
          <li>In the case of a tie, the total number of goals marked by the team across all matches is used.</li>
        </ul>

        <h2>Specific Bingo Rules</h2>
        <ul>
          <li>The Winter Tundra Portal in Dragon Shores does NOT count as a home portal.</li>
          <li>The Fireball Powerup in Dragon Shores does not count towards Powerup types.</li>
          <li>The dual powerup in Metropolis can be used as a unique powerup type. The powerup also doesn't count as one of the superfly powerups and also doesn't count as one of the fireball powerups either.</li>
          <li>Goals containing "gems in X level" means you need to get at least that many gems, you can go over at your leisure.</li>
          <li>Goals containing "combined gems in X and Y" is the sum of gems in those levels.</li>
          <li>Goals containing "X gems in both Y and Z" means at least X gems in EACH level, not a combination of the two.</li>
          <li>Hunter orbs are orbs given to you BY Hunter.</li>
        </ul>

        <p>
          More goal clarifications will be provided separately.
        </p>
      </div>
    );
  }
};
