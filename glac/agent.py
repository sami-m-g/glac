from google.adk.agents.llm_agent import Agent

from .settings import get_settings

settings = get_settings()

root_agent = Agent(
    model=settings.model,
    name="root_agent",
    description="A helpful assistant for user questions.",
    instruction="Answer user questions to the best of your knowledge",
)
