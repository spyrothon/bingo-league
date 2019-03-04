import _ from 'lodash';
import { h, Component } from 'preact';

export const RoomList = (props) => {
  const { roomsById } = props;

  const rooms = Object.values(roomsById);

  return (
    <div class="room-list">
      <table class="table">
        <thead>
          <tr>
            <th>Room</th>
            <th>Participants</th>
            <th>Last Active</th>
          </tr>
        </thead>
        <tbody>
          { rooms.map((room) => {
              return (
                <tr>
                  <td><a href={`/play/${room.room_id}`}>{room.name} (#{room.room_id})</a></td>
                  <td>{room.teams.length} Teams / {room.players.length} Players</td>
                  <td>{room.last_updated}</td>
                </tr>
              );
            })
          }
        </tbody>
      </table>
    </div>
  );
};
