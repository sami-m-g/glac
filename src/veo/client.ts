import { GoogleGenAI } from "@google/genai";

export function createGenAIClient() {
  return new GoogleGenAI({
    vertexai: process.env.GOOGLE_GENAI_USE_VERTEXAI === "1",
    project: process.env.GOOGLE_CLOUD_PROJECT,
    location: process.env.GOOGLE_CLOUD_LOCATION,
  });
}
