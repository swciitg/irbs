class Endpoints {
  static const baseUrl = String.fromEnvironment('IRBS-SERVER-URL');
  static const oneStopbaseURL = String.fromEnvironment('SERVER-URL');
  static const apiSecurityKey = String.fromEnvironment('SECURITY-KEY');
  static const getAllRooms = '/api/room';
  static const getRoomBookings = '/api/booking';
  static const getOwnedRoomBookings = '/api/booking/rooms-owned';
  static const getSpecificRoom = '/api/room';
  static const getMyRooms = '/api/room/owned';
  static const deleteBooking = '/api/booking';
  static const createBooking = '/api/booking';
  static const editRoom = '/api/room';
  static const rejectBooking = '/api/booking/reject';
  static const acceptBooking = '/api/booking/accept';
  static getHeader() {
    return {'Content-Type': 'application/json', 'security-key': Endpoints.apiSecurityKey};
  }
}
