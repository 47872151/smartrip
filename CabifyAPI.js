import axios from 'axios';
export default function CabifyAPI()
{
    const getCabifyToken = async () => {
    const res = await axios.post('https://cabify-sandbox.com/auth/api/authorization', null, {
      params: {
        grant_type: 'client_credentials',
        client_id: 'df3bc82a962b4dbe881fd87d0261b0a1',
        client_secret: 'fJvRD1bQcrmWiGsr',
      },
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    });
  
    return res.data.access_token;
  };
const getCabifyEstimates = async (token) => {
    const res = await axios.get('https://cabify-sandbox.com/api/v4/estimates/ride', {
      headers: {
        Authorization: `Bearer ${token}`,
      },
      params: {
        origin: '40.416775,-3.703790',  // LatLng origen
        destination: '40.425282,-3.699700',  // LatLng destino
      },
    });
  
    return res.data;
};

return(
        <>
        </>
);
}
