import mongoose from "mongoose";

const connectDB = async () => {
  mongoose.connection.on("connected", () => {
    console.log("MongoDB connected");
  });

  await mongoose.connect(`mongodb+srv://test:emanat1234567@testdevops.ddj33i7.mongodb.net/trendify`);
};

export default connectDB;
