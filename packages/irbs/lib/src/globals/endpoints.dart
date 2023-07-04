class Endpoints{
  static const baseUrl = 'https://swc.iitg.ac.in/irbs';
  static const apiSecurityKey = '';
  static const getAllRooms = '/api/room';
  static const getRoomBookings = '/api/booking';
  static const getSpecificRoom = '/api/room';


  static getHeader() {
    return {'Content-Type': 'application/json', 'security-key': Endpoints.apiSecurityKey};
  }
}