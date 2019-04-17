defmodule Socializer.MessageTest do
  use SocializerWeb.ConnCase

  alias Socializer.Message

  describe "#create" do
    it "creates message" do
      conversation = insert(:conversation)
      user = insert(:user)
      insert(:conversation_user, conversation: conversation, user: user)

      valid_attrs = %{
        conversation_id: conversation.id,
        user_id: user.id,
        body: "Here's what I think"
      }

      {:ok, message} = Message.create(valid_attrs)
      assert message.body == "Here's what I think"
    end
  end

  describe "#changeset" do
    it "validates with correct attributes" do
      conversation = insert(:conversation)
      user = insert(:user)
      insert(:conversation_user, conversation: conversation, user: user)

      valid_attrs = %{
        conversation_id: conversation.id,
        user_id: user.id,
        body: "Here's what I think"
      }

      changeset = Message.changeset(%Message{}, valid_attrs)
      assert changeset.valid?
    end

    it "does not validate with missing attrs" do
      changeset =
        Message.changeset(
          %Message{},
          %{}
        )

      refute changeset.valid?
    end

    it "does not validate when user is not in conversation" do
      conversation = insert(:conversation)
      user = insert(:user)

      invalid_attrs = %{
        conversation_id: conversation.id,
        user_id: user.id,
        body: "Here's what I think"
      }

      changeset = Message.changeset(%Message{}, invalid_attrs)

      refute changeset.valid?
    end
  end
end
