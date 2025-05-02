import { v2 as cloudinary } from "cloudinary";

const connectCloudinary = async () => {
  cloudinary.config({
    cloud_name: 'duijotkcj',
    api_key: '878226157565181',
    api_secret: 'cj_ET2DkjhVYvoi0Ld94Wkq4NF4',
  });
};


export default connectCloudinary;
